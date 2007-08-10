From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: C-Media 8788
Date: Fri, 10 Aug 2007 11:28:30 +0200
Message-ID: <1186738110.7828.1204694873@webmail.messagingengine.com>
References: <OF97495FB9.30DC3828-ONC2257333.0027232B-C2257333.00280C59@Sofor.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 7980524368
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 11:28:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <OF97495FB9.30DC3828-ONC2257333.0027232B-C2257333.00280C59@Sofor.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pekka.Panula@sofor.fi, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pekka.Panula@sofor.fi wrote:
> Any inside info about C-Media 8788 support, i see that repository contains 
> some sort of driver for it, but what state is it,

Analog and SPDIF playback and recording should work.

> is it working

I don't know; I don't have the hardware.

> Happy to know also if its going for Linux 2.6.23 kernel?

It's too late for that.  Probably 2.6.24 if somebody tests it until
then, but it's always possible to compile the driver separately.


Regards,
Clemens
