From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: possibly bug, sb audigy 2.5.61 and ac3 passthrough
Date: Mon, 17 Feb 2003 11:38:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302171137370.1054-100000@pnote.perex-int.cz>
References: <3E50213E.4080109@erkkila.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E50213E.4080109@erkkila.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Paul E. Erkkila" <pee@erkkila.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 16 Feb 2003, Paul E. Erkkila wrote:

> 
> Greetings,
> 
>    I'm trying to get ac3 passthrough working on my media pc.  However
> when i try and open /dev/snd/pcmC0D3p i receive a no such device error.
> I noticed a few not really resolved answers in the archives so i figured
> I'd post again. The devices exist in /dev/snd and /proc/asound/dev and
> playback and recording function correctly now (even sound via the
> optical connection to the receiver). I've read through all the online
> help i could find and am still stumped =/

ac3 passtrough is not supported for audigy yet.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
