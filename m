From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: -32 broken pipe
Date: Fri, 15 Oct 2010 16:50:29 +0200
Message-ID: <4CB86A35.6000907@ladisch.de>
References: <AANLkTim_sdgs0VAU1Ncse9h8a+-3rsB9WbXCQBibdG8B@mail.gmail.com>	<4CB807ED.8040205@ladisch.de>
	<AANLkTim3hP1TwacRsz-Gj0BD+XeaeoApuX+yVL2MJF67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7EE432442F
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 16:49:10 +0200 (CEST)
In-Reply-To: <AANLkTim3hP1TwacRsz-Gj0BD+XeaeoApuX+yVL2MJF67@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cem ERGEN <cemergen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cem ERGEN wrote:
> fist 3 soundcards of each hub works .. but 4 soundcards of each hub aren't
> work same time

Looks like a bandwidth issue.
You still didn't tell what sample format these devices are using.


Regards,
Clemens
