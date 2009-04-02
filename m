From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: vi-like key bindings for alsamixer
Date: Thu, 02 Apr 2009 08:56:21 +0200
Message-ID: <49D46195.5030609@ladisch.de>
References: <1238615895-5980-1-git-send-email-simon.hengel@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 037B52444B
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 08:56:19 +0200 (CEST)
In-Reply-To: <1238615895-5980-1-git-send-email-simon.hengel@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Simon Hengel <simon.hengel@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Simon Hengel wrote:
> I realized that 'j' and 'k' are not used nor reserved for future use
> with alsamixer. So I decided to use them as aliases for 'up' and 'down'.

But 'h' and 'l' are already used for other purposes, so these keys
cannot be used to give a consistent vi-like behaviour.

> Is this deemed suitable for the masses?

_Undocumented_ commands certainly aren't.  ;-)


Best regards,
Clemens
