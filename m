From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: salsa error message setting hwparams
Date: Fri, 24 Apr 2009 11:03:25 +0200
Message-ID: <49F1805D.8070205@ladisch.de>
References: <bca65b460904231231n6eacecc4l783ba028030d4398@mail.gmail.com>	
	<49F16899.6090704@ladisch.de>
	<bca65b460904240151h6ad716c2re9bdfb0db67703a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 72837103893
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 11:03:20 +0200 (CEST)
In-Reply-To: <bca65b460904240151h6ad716c2re9bdfb0db67703a0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: maarten van es <maarten.h.van.es@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

maarten van es wrote:
> Thanks, but that's not it. I make sure I set the correct sample rate
> with amixer first.

And what about the sample format?  I looked at the drivers; the two
sound cards do not have a common sample format.


Best regards,
Clemens
