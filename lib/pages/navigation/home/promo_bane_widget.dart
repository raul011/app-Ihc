import 'package:flutter/material.dart';

class PromoBanner extends StatefulWidget {
  final List<String> images;
  final double height;

  const PromoBanner({super.key, required this.images, this.height = 180});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_controller.hasClients) {
        int nextPage = (_currentPage + 1) % widget.images.length;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _currentPage = nextPage;
        _startAutoScroll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return Image.asset(
                widget.images[index],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
          ),
          // Indicadores
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 10 : 8,
                  height: _currentPage == index ? 10 : 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
