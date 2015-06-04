From: Juergen Bausa <Juergen.Bausa@online.de>
Subject: Re: writing an alsa driver
Date: Thu, 4 Jun 2015 17:44:19 +0000 (UTC)
Message-ID: <loom.20150604T193845-568@post.gmane.org>
References: <20150527085440.GA4445@dellaz> <1432752116.8235.25.camel@loki>
 <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150604085933.GA8494@dellaz> <1433414017.19747.36.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 13A32260601
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 19:50:12 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Z0ZHJ-0003qJ-Hz
 for alsa-devel@alsa-project.org; Thu, 04 Jun 2015 19:50:05 +0200
Received: from p57938D4C.dip0.t-ipconnect.de ([87.147.141.76])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 19:50:05 +0200
Received: from Juergen.Bausa by p57938D4C.dip0.t-ipconnect.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 19:50:05 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood <liam.r.girdwood <at> linux.intel.com> writes:

> 
> > and the sound card showed up.  So I tried to play a bit with alsamixer
> > and got
> > some cracking noise.
> > 
> 
> The speakers are probably being over powered so best to make sure with
> alsamixer that all the gains are low or muted and all unused
> inputs/outputs are muted or off before playing any audio. You can then
> gradually increase the volume to the desired level. 
> 

Just found this thread. Really nice to hear, that some peaople are working
on this and that there is some progress (hope you didn't kill your soundchip).
I also have the x205 and really apreciate that you guys are putting
so much effort on it. Realy would like to help, but I have no knowledge
on sound or kernel programming.

Juergen
