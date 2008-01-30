From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: alsa-firmware licensing
Date: Wed, 30 Jan 2008 09:13:21 +0100
Message-ID: <1201680801.28261.1234062281@webmail.messagingengine.com>
References: <477F9103.9010304@timj.co.uk>
	<1199702481.16243.1229842463@webmail.messagingengine.com>
	<479F6C57.4030309@timj.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E66EB103965
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 09:13:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <479F6C57.4030309@timj.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Jackson <lists@timj.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tim Jackson wrote:
> Clemens Ladisch wrote:
> > Please note that the emi26 and emi62 drivers still use the in-kernel
> > copies of their firmware images; the files in alsa-firmware are as yet
> > unused.
> 
> That's useful, thanks. Is the plan to drop the in-kernel ones at some 
> point then?

Yes; as soon as we find somebody with such a device to test the changes.
(It's possible that this will never happen ...)


Regards,
Clemens
