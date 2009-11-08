From: "Demian Martin" <demianm@attglobal.net>
Subject: Re: RME HDSPe AIO
Date: Sun, 8 Nov 2009 13:30:22 -0800
Message-ID: <000301ca60ba$afccd260$0f667720$@net>
References: <mailman.2708.1257713283.2074.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kcout02.prserv.net (kcout02.prserv.net [12.154.55.32])
	by alsa0.perex.cz (Postfix) with ESMTP id DCEB3103815
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 22:30:26 +0100 (CET)
In-Reply-To: <mailman.2708.1257713283.2074.alsa-devel@alsa-project.org>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Flo,

Why do you say "No. This is a pro audio card and it's full potential cannot
be used with ALSA."? What is there in Alsa that will restrict the use of the
card (or any card) for pro audio use?

The Trinnov room correction system which is a pro market product uses
Hammerfall cards and Alsa to do some very ambitious pro audio functions for
example. 


Demian Martin
Product Design Services

-----Original Message-----
Date: Sun, 08 Nov 2009 20:44:04 +0100
From: Florian Faber <faber@faberman.de>
Subject: Re: [alsa-devel] RME HDSPe AIO
To: Jonathan Leonard <jonathan.adams.leonard@gmail.com>
Cc: alsa-devel@alsa-project.org
Message-ID: <4AF71F84.6090405@faberman.de>
Content-Type: text/plain; charset=ISO-8859-1

Jonathan,

> The AIO is purported to be very similar to the 9632 and should be 
> using the snd-hdsp module.

No. It has the hdspe core and should be used as such.

> I would like to use this card in ALSA,

That's nice, but you should have checked before buying the card. The AIO is
not supported.

> Besides my individual circumstance I wonder if ALSA should not be 
> accomodating this great card somehow.

No. This is a pro audio card and it's full potential cannot be used with
ALSA.


Flo
--
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
