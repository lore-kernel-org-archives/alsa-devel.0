From: Carl Lee <golakers9999@yahoo.com>
Subject: via82xx + 4 cs4297 audio codec
Date: Wed, 14 May 2003 15:48:45 -0700 (PDT)
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20030514224845.80447.qmail@web13301.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Alsa-Community,

I have a custom audio card with the Via 8233
controller and 4 CS4297 codecs.  I want each of the 4
codecs to be a seperate "player."  So I want the
ability to play 4 different files at the same time,
one file per codec.  My question is does the alsa Via
8233 driver already support this or do I have to make
some code modifications?  Using alsa.rc6 (an older
library) I was able to play a file (using mpg123) on
the first codec no problem.  Any ideas on how to play
files on the remaining 3 codecs?  Is there some module
parameters I need to supply?  If I need to change the
code, no problem, I have to do it..please send me some
ideas and how long you think it would take for a
novice like myself.

Thanks in advance.

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
