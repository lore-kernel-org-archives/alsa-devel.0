From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Logical device name for 4-channel microphones?
Date: Tue, 24 Apr 2012 16:08:45 +0200
Message-ID: <4F96B3ED.3070007@ladisch.de>
References: <1335011052.2268.18.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C27E0243BC
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2012 16:04:54 +0200 (CEST)
In-Reply-To: <1335011052.2268.18.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tanu Kaskinen wrote:
> My problem is that I'd like to make Pulseaudio handle 4-channel webcam
> microphones[2], but I'm not aware of any input device names for
> 4-channel devices. Are there such device names?

These device name are useful only for device types that are generic
enough.  Four-channel microphones aren't.


Regards,
Clemens
