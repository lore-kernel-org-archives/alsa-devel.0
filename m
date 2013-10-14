From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: dsp after dmix
Date: Mon, 14 Oct 2013 09:08:10 +0200
Message-ID: <525B985A.30409@ladisch.de>
References: <CAOf5uwmrS1AZrmKfbUYokU1Azdd2dZv2=Z=fGp+UQyy_mW1ijQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 08F64260864
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 09:08:13 +0200 (CEST)
In-Reply-To: <CAOf5uwmrS1AZrmKfbUYokU1Azdd2dZv2=Z=fGp+UQyy_mW1ijQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Michael Trimarchi wrote:
> My problem is to apply filtering after dmix plugin.

The dmix plugin works only on top of a "hw" device.


Regards,
Clemens
