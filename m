From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] CS4205 (snd-intel8x0) missing recording inputs
Date: Mon, 18 Nov 2002 10:10:48 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211180948540.738-100000@pnote.perex-int.cz>
References: <000001c28e7d$179ce690$ab1f830a@ICO>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <000001c28e7d$179ce690$ab1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 17 Nov 2002, Ivica Bukvic wrote:

> This driver seems to be notorious right now with its features (or better
> lack thereof). When using Alsa driver for the above-mentioned driver
> found in many of the current laptops, not all inputs can be selected for
> recording. For instance, line-in is available as an input source, but
> mic-in surprisingly isn't.

Could you send me output from 'amixer contents' ?

> One more thing is that CS4205 is a full-blown dsp so while it is

Are you kidding? It's a simple AC'97 codec. Please, check the manufacture 
information before flames (www.crystal.com).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
