From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: laptop multichannel ethernet OR PCMCIA sound cards
Date: Wed, 01 Jul 2009 22:24:14 +1200
Message-ID: <4A4B394E.7090707@audioscience.com>
References: <1246420893.7599.7.camel@flatmax>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C7F5243FE
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 22:10:06 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MM682-0007V6-PD
	for alsa-devel@alsa-project.org; Wed, 01 Jul 2009 20:10:03 +0000
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 01 Jul 2009 20:10:02 +0000
Received: from eblennerhassett by 121-72-250-62.cable.telstraclear.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 01 Jul 2009 20:10:02 +0000
In-Reply-To: <1246420893.7599.7.camel@flatmax>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matt Flax wrote:
> We are after an ultra low latency connection to a multichannel in/out
> sound card for a laptop. We want a portable system and don't want to
> network to a different computer to achieve this goal.
> 
> As we are after ultra low latency, we are interested in both PCMCIA and
> ethernet (gigabit) solutions.
> 
> Is anyone aware of any such ultra low latency hardware ?

Can you define what you require.

Do you want analog or digital audio I/O?

Do you need low latency in, out or both?

What samplerates do you need?

What latency would be acceptable (say how many milliseconds or 
microseconds).

regards

Eliot
