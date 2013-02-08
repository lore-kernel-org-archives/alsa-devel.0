From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Trouble about Roland UA-55 and snd-usb-audio module
Date: Fri, 08 Feb 2013 13:55:50 +0100
Message-ID: <5114F5D6.4070404@ladisch.de>
References: <50A349A5.6010403@firebuntu.com> <50A34C36.7080506@ladisch.de>
 <50A56FE6.3050009@firebuntu.com> <loom.20130109T124035-460@post.gmane.org>
 <50FC3009.9070401@ladisch.de> <loom.20130125T202229-943@post.gmane.org>
 <loom.20130128T221942-836@post.gmane.org> <5106F107.90704@ladisch.de>
 <loom.20130131T042847-100@post.gmane.org> <51140FFD.3060907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 00E292615B6
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 13:55:52 +0100 (CET)
In-Reply-To: <51140FFD.3060907@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Smeefer <smeefer@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I wrote:
>       ALSA: usb-audio: detect implicit feedback on Roland devices

This probably works only with the first rate (44.1 kHz), but please
test anyway.


Regards,
Clemens
