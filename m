From: joy ping <joy@pingfm.org>
Subject: Re: What is the current status of the alsa sound server
 (signal polling)?
Date: Fri, 19 Apr 2002 16:03:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.43.0204191600020.775-100000@localhost.localdomain>
References: <000101c1e766$39a37a60$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from audio13.medien.uni-weimar.de (audio13.medien.uni-weimar.de [141.54.172.33])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA03977
	for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2002 14:46:07 +0200
In-Reply-To: <000101c1e766$39a37a60$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ivica Bukvic <ico@fuse.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi,

im working on a kind of asoundrc-mini-howto, if you are interested in i
can send you a pre-version. as i know, polling is not supported with alsa,
and its not configurable at runtime.

____
joy

On Fri, 19 Apr 2002, Ivica Bukvic wrote:

> Hi all! A while ago I was inquiring about the current status of the
> .asoundrc documentation, as well as the feasibility of creating "mock"
> devices that would allow polling of the audio i/o resources of the
> soundcard whose driver's limitations and/or hardware limitations
> currently do not support hardware polling.
>
> I am just wondering if anyone had any luck in figuring out how to do
> that using .asoundrc and whether that is even possible at this point.
>
> Also, what is the current status of gstreamer in this department and
> jack? (I tried artsd and that one simply doesn't cut it)
>
> Any info on this issue would be utmostly appreciated!
>
> Ico
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
