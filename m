From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [PATCH] WM97xx AC97 codec controls
Date: Tue, 19 Jul 2005 22:53:01 +0200
Message-ID: <m28y02o6vm.fsf@vador.mandriva.com>
References: <1121769565.6237.32.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1121769565.6237.32.camel@cearnarfon> (Liam Girdwood's message of
	"Tue, 19 Jul 2005 11:39:25 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Liam Girdwood <liam.girdwood@wolfsonmicro.com> writes:

> This patch adds support to the WM97xx family for non standard AC97 codec
> controls. It exposes the extra (non std AC97) features of each codec as
> a new kcontrol.
> 
> Changes:-
> 
>   o Enhanced current WM97xx support to provide additional controls.
>   o Added AC97_HAS_NO_MIC and AC97_HAS_NO_TONE

you stripped out some comments in your patch :-(



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
