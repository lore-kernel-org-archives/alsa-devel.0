From: Lee Revell <rlrevell@joe-job.com>
Subject: snd_pcm_link documentation
Date: Sat, 11 Sep 2004 21:59:57 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094954396.1306.102.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: alsa-user
List-Id: alsa-devel@alsa-project.org

Hmm, I think I may have an explanation for the perennial favorite
complain about ALSA, "there's no documentation!".  It's a Google bug.

Googling for "snd_pcm_link documentation" produces only 15 results:

http://www.google.com/search?q=snd_pcm_link+documentation&num=50&hl=en&lr=&ie=UTF-8&safe=off&output=search

The correct page does not appear at all:

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#a61

How is it that the full API docs have been posted on alsa-project.org
for ages, and the best Google can do is one lousy page of code examples
and old mailing list postings?

No wonder so many people (myself included) get so worked up about the
"lack of ALSA documentation"; there effectively isn't any unless you
already know exactly where to look.

Probably all the internal links in the Doxygen-derived HTML are
triggering some heuristic to detect Google-spamming (or whatever the
heck they call it).

Lee


 



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
