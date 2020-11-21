import 'package:auto_kobe/blocs/blocs.dart';
import 'package:auto_kobe/widgets/widgets.dart';
import 'package:brand_repository/brand_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';

class ListingModelsList extends StatefulWidget {
  final Brand brand;
  final Function(Model) onTap;

  ListingModelsList({
    Key key,
    @required this.brand,
    @required this.onTap,
  }) : super(key: key);

  @override
  _ListingModelsListState createState() => _ListingModelsListState();
}

class _ListingModelsListState extends State<ListingModelsList> {
  final _scrollController = ScrollController();
  ModelBloc _modelBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _modelBloc = context.bloc<ModelBloc>()..add(ModelFetched(widget.brand));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModelBloc, ModelState>(
      listener: (context, state) {
        if (!state.hasReachedMax && _isBottom) {
          _modelBloc..add(ModelFetched(widget.brand));
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case ModelStatus.failure:
            return const Center(child: Text('failed to fetch listings'));
          case ModelStatus.success:
            if (state.models.isEmpty) {
              return const Center(child: Text('no models'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.models.length
                    ? BottomLoader()
                    : _ModelItem(
                        model: state.models[index],
                        // onTap: widget.onTap(state.models[index]),
                        onTap: widget.onTap,
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.models.length
                  : state.models.length + 1,
              controller: _scrollController,
            );
          case ModelStatus.missingBrand:
            return const Center(child: Text("missing brand"));
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      // _modelBloc.add(ModelFetched(context.bloc<ModelBloc>().state.brand));
      _modelBloc.add(ModelFetched(widget.brand));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _ModelItem extends StatelessWidget {
  final Model model;
  final Function(Model) onTap;

  const _ModelItem({
    Key key,
    @required this.model,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    return ListTile(
      title: Text(model.name),
      isThreeLine: true,
      subtitle: Text(model.id.toString()),
      dense: true,
      onTap: () => onTap(model),
    );
  }
}
