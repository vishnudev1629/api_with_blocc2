import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/product_bloc.dart';
import '../Bloc/product_event.dart';
import '../Bloc/product_state.dart';
import '../Product_link.dart';
import 'Products.dart';

class APIBlocHome  extends StatelessWidget {
  const APIBlocHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(productRepositort()),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(title: const Text('The BloC App')),
          body: blocBody()),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        productRepositort(),
      )..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserErrorState) {
            return const Center(child:  Text("Error"));
          }
          if (state is UserLoadedState) {
            List<Products> userList = state.users;
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Card(
                        color: Theme.of(context).primaryColor,
                        child: ListTile(
                            title: Text(
                              '${userList[index].brand}  ${userList[index].id}',
                              style: const TextStyle(color: Colors.white),
                            ),

                            subtitle: Text(
                              '${userList[index].rating}',
                              style: const TextStyle(color: Colors.white),
                            ),

                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  userList[index].thumbnail.toString()),
                            )
                        )),
                  );
                });
          }

          return Container();
        },
      ),
    );
  }
}
