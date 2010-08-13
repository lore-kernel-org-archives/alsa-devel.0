From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [REGRESSION 2.6.35+] Pulseaudio fails to work with
 sound device
Date: Fri, 13 Aug 2010 09:08:25 +0200
Message-ID: <4C64EF69.7040804@ladisch.de>
References: <1281644945.3893.18.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 28AC1103809
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 09:08:01 +0200 (CEST)
In-Reply-To: <1281644945.3893.18.camel@maxim-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Maxim Levitsky wrote:
> Trying to migrate to git master of kernel tree I see that my sound
> stopped working.

Probably this bug:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-August/030526.html


Regards,
Clemens
