From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa error
Date: Tue, 07 Jul 2015 09:14:37 +0200
Message-ID: <559B7C5D.50401@ladisch.de>
References: <SIXPR04MB253D88AF361F3A2E8368EE6C3920@SIXPR04MB253.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 839B9261A95
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 09:14:39 +0200 (CEST)
In-Reply-To: <SIXPR04MB253D88AF361F3A2E8368EE6C3920@SIXPR04MB253.apcprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Srinivasan S wrote:
> Am facing the below error, could you please let me know what could be the issue leading to this error
>
> Feb 11 18:48:22 kernel: [  210.508525] ALSA sound/core/pcm_native.c:2080 snd_pcm_hw_constraints_complete failed

A bug in your driver.


Regards,
Clemens
