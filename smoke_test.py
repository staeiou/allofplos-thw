from allofplos import Article

"""
"""

def main():
    article = Article(doi="'10.1371/journal.pone.0069131")
    if article.local:
        print("I am found myself!")


if __name__ == "__main__":
    main()