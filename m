From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: OSS/4Front
Date: Thu, 21 Jun 2007 02:44:16 -0500
Message-ID: <20070621074417.04A7D1158CC@ws1-7.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id D36F8103826
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 09:46:34 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	1546918001AA
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 07:44:17 +0000 (GMT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

> You could compare <http://manuals.opensound.com/devlists/Linux.html>
> with ALSA's sound card matrix, but the latter tends to be out of date.
> 

Yeah, that thing is oooooold. Hopefully the new wiki on't be too bad.

> > With the recent open sourcing of OSS, it would be nice to port code
> > to ALSA for devices that are only currently covered by OSS.
> 
> AFAICS all devices supported by the open-source OSS are also supported
> by ALSA.
> 

Ah, looks can be deceiving. Although both systems have 'geode' support,
it seems that the OSS driver supports the CS5530 VSA2 and the SC1200.

Also, there's an open bug for the Neomagic 256 driver, which may have a
solution hiding away in OSS somewhere (someone with the hardware is
hopefully going to help me look into that).
There's a couple of things right off the bat and I don't know ALSA very
well at all compared to most of you.
And yeah, I know this stuff isn't in great demand, but it'd be nice if
people weren't able to say that OSS can do XYZ and ALSA can't.

Ash


-- 
Get a Free E-mail Account at Mail.com!
Choose From 100+ Personalized Domains
Visit http://www.mail.com today
