From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: emu10k1, midi on audigy platinum ex
Date: Tue, 29 Mar 2011 14:22:17 +0200
Message-ID: <4D91CEF9.4030009@ladisch.de>
References: <4D91B8D7.2000504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 44631103937
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 14:21:01 +0200 (CEST)
In-Reply-To: <4D91B8D7.2000504@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Goncalo Pinheira <goncalopp@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Goncalo Pinheira wrote:
> I've noticed midi in (DIN connector) on an audigy platinum ex doesn't work.

IIRC you have to set the "enable_ir" module parameter.


Regards,
Clemens
