---
title: "leetcode #211 Add and Search Word - Data structure design"
date: "2015-05-17T18:23:09+08:00"
categories:
tags:
---

                                            
Design a data structure that supports the following two operations:

void addWord(word)
bool search(word)


search(word) can search a literal word or a regular expression string containing only letters<code>a-z</code> or
<code>.</code>. A <code>.</code> means it can represent any one letter.
For example:
addWord("bad")
addWord("dad")
addWord("mad")
search("pad") -> false
search("bad") -> true
search(".ad") -> true
search("b..") -> true
做这道题，学了个新的数据结构-----trie树

```cpp
class WordDictionary {
public:
	typedef struct TrieNode {
		TrieNode * child[26];
		bool isendWord;

		TrieNode():isendWord(false){
		    for(int i = 0; i < 26; i ++)
				*(child + i) = NULL;
		}

	}* trie_root, * trie_node;
    
    WordDictionary(){
	    root = new TrieNode();
	}

	void addWord(string word) {
	    trie_node p = root;
		for(string::iterator it = word.begin(); it != word.end(); it ++) {
			int i = *it - 'a';
		    if(!p->child[i]) 
				p->child[i] = new TrieNode();
			p = p->child[i]; 
		}
		p->isendWord = true; 
	} 

	bool search(string word){
	    return searchWord(word, root, 0);
	}
    
	bool searchWord(string word, trie_node p, int i){
	    if(i == word.size()) return p->isendWord;
		if(word[i] == '.') {
		    for(int j = 0; j < 26; j++){
			    if( p->child[j] && searchWord(word, p->child[j], i + 1) )
					return true;
			}
			return false;
		}
		else
			return p->child[word[i] - 'a'] && searchWord(word, p->child[word[i] - 'a'], i + 1);
	}

private:
	trie_root root;

};
```

