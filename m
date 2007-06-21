From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: OSS/4Front
Date: Thu, 21 Jun 2007 09:15:47 +0200
Message-ID: <1182410147.5796.1196291339@webmail.messagingengine.com>
References: <20070621012308.C0A1816427C@ws1-4.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 883DF10382B
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 09:15:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070621012308.C0A1816427C@ws1-4.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ash Willis <ashwillis@programmer.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ash Willis wrote:
> Does anyone know if there's any kind of list showing a comparison of
> hardware support between ALSA and OSS/4Front?

You could compare <http://manuals.opensound.com/devlists/Linux.html>
with ALSA's sound card matrix, but the latter tends to be out of date.

> With the recent open sourcing of OSS, it would be nice to port code
> to ALSA for devices that are only currently covered by OSS.

AFAICS all devices supported by the open-source OSS are also supported
by ALSA.

The Lynx, Sonorus and Envy24 drivers are not open source.


Regards,
Clemens
