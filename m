From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question on usbaudio.c: snd_usb_find_csint_desc
Date: Mon, 26 Jan 2009 09:53:44 +0100
Message-ID: <497D7A18.3030308@ladisch.de>
References: <497A522E.9060901@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B41E724333
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2009 09:53:47 +0100 (CET)
In-Reply-To: <497A522E.9060901@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: LCID Fire <lcid-fire@gmx.net>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

LCID Fire wrote:
> I was looking at 'snd_usb_find_csint_desc' and I really wonder why there 
> is a while loop since it seems to me that the variables don't really 
> change.

p changes.


HTH
Clemens
