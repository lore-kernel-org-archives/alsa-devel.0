From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: National Semiconductor Corporation Open Source
 License
Date: Sat, 1 Mar 2003 19:33:46 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303011932130.9280-100000@pnote.perex-int.cz>
References: <20030301182634.GA465@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030301182634.GA465@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 1 Mar 2003, Martin Langer wrote:

> 
> Hi,
> 
> the ALSA-0.5 Geode Driver (geode.c) on
> http://www.gctglobal.com/Download/alsa-geode.tar.gz 
> which still waits for a port to 0.9 has the following license, which is not
> GPL. Is it really possible to include such a license into the alsa package?
> (I see the big problem in the export laws because the kernel is under GPL
> without an export rule)
> 
> I won't use this code, but I'm definitely no license expert. Or is it possible
> to use a different license for a port (IMHO it's more than a modification, but
> I don't know the definition of a lawyer in this case)
> 
> On the other hand I found another older file in the tgz called geode_BAK.c
> without a license text. Same license, no license or GPL for that file?
> 
> Or can a port use a dual license (GPL/NSC OSL)?
> 
> Anybody there who knows something?

I think that if you write the whole driver without cut-n-paste using only
hardware information from the original source then you can use your own 
license without problems.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
