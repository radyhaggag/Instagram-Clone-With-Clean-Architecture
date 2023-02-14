import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/story/story_text.dart';
import '../../../../core/media_query.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_size.dart';
import '../../../../core/utils/app_strings.dart';
import '../bloc/story_bloc.dart';

class AddTextToStory extends StatefulWidget {
  final StoryBloc storyBloc;
  const AddTextToStory({super.key, required this.storyBloc});

  @override
  State<AddTextToStory> createState() => _AddTextToStoryState();
}

class _AddTextToStoryState extends State<AddTextToStory> {
  late final TextEditingController textController;
  late bool isComplete;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    isComplete = false;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<StoryBloc>().add(ChangeStoryText(StoryText(
          color: AppColors.storyTextColors.first.value.toRadixString(16),
          dx: context.width / 2,
          dy: context.height / 2,
          fontSize: FontSize.body,
          text: '',
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isComplete ||
            (widget.storyBloc.storyText != null &&
                widget.storyBloc.storyText!.text.isEmpty))
          Align(
            alignment: Alignment.center,
            child: TextFormField(
              controller: textController,
              textAlign: TextAlign.center,
              style: _storyStyle(widget.storyBloc.storyText),
              onFieldSubmitted: (value) {
                setState(() => isComplete = true);
              },
              onChanged: (value) {
                widget.storyBloc.add(ChangeStoryText(
                    widget.storyBloc.storyText?.copyWith(text: value)));
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                hintText: AppStrings.typeSomething,
                hintStyle: _storyStyle(widget.storyBloc.storyText),
                border: InputBorder.none,
                enabled: true,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        if (isComplete && widget.storyBloc.storyText!.text.isNotEmpty)
          Positioned(
            left: widget.storyBloc.storyText!.dx * 0.8,
            top: widget.storyBloc.storyText!.dy * 0.8,
            child: Draggable(
              onDragUpdate: (details) {
                widget.storyBloc
                    .add(ChangeStoryText(widget.storyBloc.storyText?.copyWith(
                  dx: details.localPosition.dx,
                  dy: details.localPosition.dy,
                )));
              },
              feedback: Material(child: Container()),
              child: InkWell(
                onTap: () => setState(() => isComplete = false),
                child: SizedBox(
                  width: context.width,
                  child: Text(
                    widget.storyBloc.storyText?.text ?? "",
                    maxLines: 10,
                    softWrap: true,
                    style: _storyStyle(widget.storyBloc.storyText),
                  ),
                ),
              ),
            ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Slider(
                value: widget.storyBloc.storyText?.fontSize ?? FontSize.body,
                min: FontSize.light,
                max: AppSize.s50,
                activeColor: widget.storyBloc.storyText != null
                    ? Color(
                        int.parse(widget.storyBloc.storyText!.color, radix: 16))
                    : AppColors.white,
                thumbColor: widget.storyBloc.storyText != null
                    ? Color(
                        int.parse(widget.storyBloc.storyText!.color, radix: 16))
                    : AppColors.white,
                inactiveColor: AppColors.white.withOpacity(.5),
                onChanged: (value) {
                  widget.storyBloc.add(ChangeStoryText(
                      widget.storyBloc.storyText?.copyWith(fontSize: value)));
                },
              ),
              SizedBox(
                height: AppSize.s60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: AppColors.storyTextColors.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      widget.storyBloc.add(ChangeStoryText(
                        widget.storyBloc.storyText?.copyWith(
                            color: AppColors.storyTextColors[index].value
                                .toRadixString(16)),
                      ));
                    },
                    child: Container(
                      width: AppSize.s40,
                      height: AppSize.s40,
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.only(
                        left: AppSize.s10,
                        bottom: AppSize.s20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.storyTextColors[index],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle _storyStyle(StoryText? storyText) =>
      Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: storyText != null
                ? Color(int.parse(storyText.color, radix: 16))
                : AppColors.white,
            fontSize: storyText?.fontSize,
          );
}
