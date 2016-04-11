From: Martin Tarenskeen <m.tarenskeen@zonnet.nl>
Subject: Re: [PATCH 1/2] amidi: ignore not only Active Sensing
 but all System Real-Time messages
Date: Mon, 11 Apr 2016 13:47:09 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1604111345250.5639@localhost.localdomain>
References: <570AA980.3070802@ladisch.de>
 <alpine.DEB.2.02.1604110858100.9999@lnxricardw1.se.axis.com>
 <alpine.LFD.2.20.1604111304310.4695@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpsmtpb-ews06.kpnxchange.com (cpsmtpb-ews06.kpnxchange.com
 [213.75.39.9]) by alsa0.perex.cz (Postfix) with ESMTP id C7534261A76
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 13:47:12 +0200 (CEST)
In-Reply-To: <alpine.LFD.2.20.1604111304310.4695@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel mailinglist <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org



On Mon, 11 Apr 2016, Martin Tarenskeen wrote:

> I can image keeping the -a (--allow-realtime) option 
> the way it is

I meant to write -a (--active-sensing

--allow-realtime is what I have now in my home-hacked patched version.

-- 

MT
