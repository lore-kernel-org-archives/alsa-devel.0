From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb-audio mic problem with Polycom C100S
Date: Fri, 27 Sep 2013 15:14:39 +0200
Message-ID: <524584BF.5040908@ladisch.de>
References: <alpine.SOC.1.00.1309251653350.17530@math.ut.ee>
 <52458079.3090809@ladisch.de> <alpine.SOC.1.00.1309271608540.1451@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4F30A2656FE
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 15:14:46 +0200 (CEST)
In-Reply-To: <alpine.SOC.1.00.1309271608540.1451@math.ut.ee>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Meelis Roos <mroos@linux.ee>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Meelis Roos wrote:
>>> I tried to use Skype (4.1) with Polycom Communicator C100S. Audio
>>> output works fine but mic seems to be dead, although it is set to
>>> capture and volume is even max.
>
> Simple mixer control 'Mic',0
>   Limits: Capture 0 - 64
>   Mono: Capture 0 [0%] [0.00dB] [on]

This is at the lowest setting.


Regards,
Clemens
