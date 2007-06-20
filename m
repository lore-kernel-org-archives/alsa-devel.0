From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: $1000 bounty for getting audio working under linux
 on a Osprey 440
Date: Wed, 20 Jun 2007 07:59:07 +0200
Message-ID: <1182319147.5073.1196082513@webmail.messagingengine.com>
References: <Pine.LNX.4.58.0706191425360.15975@barney.robotics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0117724476
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 07:59:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0706191425360.15975@barney.robotics.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nathan Allen Stratton <nathan@robotics.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nathan Allen Stratton wrote:
> Need to get audio working on Osprey 440 card.
> 
> The card is bt878 based, and ViewCast says it is supported on linux
> however not something they support. Audio is not detected by default, but
> does how up when you do a modprobe snd-bt87x load-all(see below). However
> I have not been able to pull audio from the card (only get high pitched
> noise).

Is it possible to record audio in Windows (without going through a
separate sound card)?

Did you try the digital input and the three analog inputs?


Regards,
Clemens
