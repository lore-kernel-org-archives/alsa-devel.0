From: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] Enable HP output on nVidia
	Corporation	MCP79 HDA (rev b1) (Macbook Pro 5, 5)
Date: Thu, 30 Jul 2009 15:05:43 +0200
Message-ID: <20090730130543.GB11216@calypso>
References: <20090730124426.GA11216@calypso> <s5h1vnyfi9b.wl%tiwai@suse.de>
Reply-To: Stelian Pop <stelian@popies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sd-11162.dedibox.fr (sd-11162.dedibox.fr [88.191.70.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DD1310391E
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 15:05:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1vnyfi9b.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andreas =?iso-8859-1?Q?N=FC=DFlein?= <nutz@unfoog.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 30, 2009 at 02:49:20PM +0200, Takashi Iwai wrote:

> Great, this is *the* missing piece!

Yup. Everything seems to work fine now.

> I'm going to merge the hda-cirrus patch back to the (stable) sound GIT
> tree so that it'll be merged into the next 2.6.32 kernel.

Cool. Thanks !

Stelian.
-- 
Stelian Pop <stelian@popies.net>
