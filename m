From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Re: [Alsa-user] Re: Broken emu10k/SB Live driver?
Date: Fri, 11 Oct 2002 14:10:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210111409540.1244-100000@pnote.perex-int.cz>
References: <1034325263.474.37.camel@diesel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1034325263.474.37.camel@diesel>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Martin Soto <soto@informatik.uni-kl.de>
Cc: torben hohn <torbenh@gmx.de>, alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 11 Oct 2002, Martin Soto wrote:

> I'm however attaching a small patch to emufx.c that fixes a bug in the
> implementation of the CODE_PEEK ioctl.  It must be applied to alsa in
> order for my userland program to work.

It's already in CVS.

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
