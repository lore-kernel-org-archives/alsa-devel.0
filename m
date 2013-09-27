From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb-audio mic problem with Polycom C100S
Date: Fri, 27 Sep 2013 14:56:25 +0200
Message-ID: <52458079.3090809@ladisch.de>
References: <alpine.SOC.1.00.1309251653350.17530@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1C2D32656CB
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 14:56:28 +0200 (CEST)
In-Reply-To: <alpine.SOC.1.00.1309251653350.17530@math.ut.ee>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Meelis Roos <mroos@linux.ee>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Meelis Roos wrote:
> I tried to use Skype (4.1) with Polycom Communicator C100S. Audio
> output works fine but mic seems to be dead, although it is set to
> capture and volume is even max.

Please show the output of "amixer scontents" for this device.


Regards,
Clemens
