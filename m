From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: question regarding latest CS4205 laptop soundcard driver
Date: Thu, 28 Feb 2002 14:12:13 +0000
Message-ID: <20020228141213.K18253@ecs.soton.ac.uk>
References: <200202271510.KAA11571@renoir.op.net> <1014837078.10692.18.camel@meowing.memh.uc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ecs.soton.ac.uk (inanna.ecs.soton.ac.uk [152.78.65.48])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA13141
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2002 15:12:15 +0100
Received: (from swh@localhost)
	by ecs.soton.ac.uk (8.11.6/8.11.2) id g1SECD818650
	for alsa-devel@alsa-project.org; Thu, 28 Feb 2002 14:12:13 GMT
Content-Disposition: inline
In-Reply-To: <1014837078.10692.18.camel@meowing.memh.uc.edu>; from ico@fuse.net on Wed, Feb 27, 2002 at 02:11:18 -0500
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 27, 2002 at 02:11:18 -0500, Ivica Bukvic wrote:
> Well that's exactly where lies the problem. Most of the laptop
> soundcards have marginal Alsa (and for that matter OSS) support. The
> only ones that I am aware of so far of being able to do multiple
> hardware streams in Linux are es1969 (thanks to Patrick Shirkey) and
> Trident that you have mentioned (although I am not sure what model and
> in what laptop), and possibly Yamaha chipset. That is rather sparse
> choice and usually laptops that utilize these are either outdated or
> have other peripherals weak (i.e. marginal video card).

I believe that the Maestro3i in the dell 8100 can do multiple streams:
I can run xmms (oss emulation) and jack (alsa native) at the same
time, though that might be down to something else.

- Steve

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
