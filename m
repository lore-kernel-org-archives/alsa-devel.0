From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: cmipci surround sound front-left plays on lfe
Date: Fri, 10 Sep 2010 09:10:26 +0200
Message-ID: <4C89D9E2.1070008@ladisch.de>
References: <4C89D660.4020705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 91FA82447F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:10:03 +0200 (CEST)
In-Reply-To: <4C89D660.4020705@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tom Corner <tom.c.corner@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tom Corner wrote:
> The surround sound 5.1 is playing fine except channel 0 (front-left)
> is playing on the woofer.

And the software's front left channel is also playing on the front left
speaker?  And the subwoofer channel isn't playing on any speaker?

> I can redirect the output on 0 to right-front successfully using
> .asoundrc and "ttable.0.1 1".

I do not understand how this is related to your problem.


Regards,
Clemens
