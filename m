From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: aplay CVS now works. alsamixer CVS is slightly odd.
Date: Sun, 22 Sep 2002 09:44:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209220943300.531-100000@pnote.perex-int.cz>
References: <20020921213246.44092.qmail@web40604.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020921213246.44092.qmail@web40604.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 21 Sep 2002, [iso-8859-1] Chris Rankin wrote:

> Hi,
> 
> With the latest changes to pcm.h and pcm.c, the CVS
> version of aplay now works OK, thanks. However, the
> CVS alsamixer seems to be displaying its graphics
> incorrectly. Some of the columns (with the SB Live!
> card) have no numbers underneath them, and the "Mic
> Select" and "Mono Output Select" columns are missing
> entirely except for the tags "Mic1" and "Mix"
> respectively.

Note that these controls are enumerated (it's a list of available 
options). If you have an idea for better representation, let us know.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
