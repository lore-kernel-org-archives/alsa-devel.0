From: Chris Pemberton <cjpembo@gmail.com>
Subject: Re: OSS/4Front
Date: Wed, 20 Jun 2007 21:24:32 -0500
Message-ID: <4679E160.5060500@gmail.com>
References: <20070621012308.C0A1816427C@ws1-4.us4.outblaze.com>
	<1182390465.15219.229.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id B5F201037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 04:35:35 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.embarq.synacor.com (Postfix) with ESMTP id 19658268024
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 22:35:32 -0400 (EDT)
Received: from smtp.embarq.synacor.com ([127.0.0.1])
	by localhost (smtp01.embarq.synacor.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id p0ZwAZSH2OjZ for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 22:35:31 -0400 (EDT)
Received: from [76.7.248.5] (unknown [76.7.248.5])
	by smtp.embarq.synacor.com (Postfix) with ESMTP id 6F965267FB0
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 22:35:31 -0400 (EDT)
In-Reply-To: <1182390465.15219.229.camel@razman.gruemaster.com>
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

Tobin Davis wrote:
> In reviewing the GPL2 version of their code, I can't see any benefits to
> the Intel HD Audio code base.  I'll build and test it to see if there is
> any improvements, but I'm doubting it.  There are no widget controls
> specific to each chip.
> 
> Tobin
> 
> On Wed, 2007-06-20 at 20:23 -0500, Ash Willis wrote:
> 
>> Hi,
>> Does anyone know if there's any kind of list showing a comparison of
>> hardware support between ALSA and OSS/4Front?
>>
>> With the recent open sourcing of OSS, it would be nice to port code
>> to ALSA for devices that are only currently covered by OSS. There
>> has to be at least a few devices that we can grab support for, right?
>> It may at least provide us with insight into a few bugfixes.
>>
>> Ash
>>
> 
Just tried the OSS HD Audio driver a few minutes ago: the kernel module 
wouldn't even load on my Lenovo laptop.

Chris
