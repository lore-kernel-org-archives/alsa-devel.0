From: drclaw@dogsolitude.org
Subject: Re: PCMCIA and snd-hdsp
Date: Wed, 28 Aug 2002 09:58:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020828135853.GA22885@dogsolitude.org>
References: <20020828055904.GA770@finnendahl.de> <200208281233.g7SCXO255193@icemserv.folkwang-hochschule.de> <20020828162406.GB557@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from pylon.dogsolitude.org (postfix@map-dsl-134.map.com [208.168.78.134])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA08405
	for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2002 19:43:34 +0200
Content-Disposition: inline
In-Reply-To: <20020828162406.GB557@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, I'm running woody w/ pcmcia-cs_3.1.33-6 and my own custom build, but
unpatched kernel 2.4.18, and a recent ALSA CVS checkout.  I haven't
tried my brand spanking new hdsp very much (been working), but it seems
to load up nicely.  I'll try to compile up 2.4.19 tonight to see if that
breaks anything, and if it doesn't I'll wager that the problem lies with
cardservices.  BTW, I have a fujitsu laptop I'm using it with, which
appears to have very similar internals to yours, lots of ali devices all
over the place.  

784 - Michael C. Piantedosi - drclaw@dogsolitude.org


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
