From: Martin Langer <martin-langer@gmx.de>
Subject: Re: drivers in alsa-driver tree with 2.6 kernels
Date: Thu, 11 Mar 2004 19:08:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040311180847.GA564@tuba.home>
References: <s5hd67jldi8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hd67jldi8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 11, 2004 at 02:27:59PM +0100, Takashi Iwai wrote:
> Hi,
> 
> does anyone use the following drivers with a 2.6 kernel successfully?
> if it's confirmed, i'd like to move them to alsa-kernel tree, so that
> they can be submitted to 2.6 linux tree soon.
> 
> - snd-usb-usx2y
> - snd-hdspm
> - snd-intel8x0m
> 
> 
> note that now au88x0 and atiixp drivers are already in alsa-kernel
> tree.
> 

Don't forget snd-msnd in the isa directory. I guess it's quite a long time
in the alsa-driver tree. ( btw: I don't have such a card. )

bye,
martin


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
