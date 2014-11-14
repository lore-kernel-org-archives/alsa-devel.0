From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: Re: Pop and offsets at start of audio playback/record
 for SGTL5000 on i.MX28
Date: Fri, 14 Nov 2014 12:58:40 +1100
Message-ID: <546561D0.9090401@beamcommunications.com>
References: <54655E35.9000807@beamcommunications.com>
 <CAOf5uwkh7inpgOO8affswziTnKV3-9_4U6v2G55JnTHb-RkCyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-SG1-obe.outbound.protection.outlook.com
 (mail-sg1on0057.outbound.protection.outlook.com [134.170.132.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C3312604E8
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 02:58:54 +0100 (CET)
In-Reply-To: <CAOf5uwkh7inpgOO8affswziTnKV3-9_4U6v2G55JnTHb-RkCyA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 14/11/14 12:45, Michael Trimarchi wrote:
>
> Hi
>
> Il 14/nov/2014 09:44 "Craig McQueen" 
> <craig.mcqueen@beamcommunications.com 
> <mailto:craig.mcqueen@beamcommunications.com>> ha scritto:
> >
> > I'm testing the 3.14.19 kernel for i.MX28 EVK, which has an SGTL5000 
> CODEC. I've also tested on the 3.18-rc4 kernel and confirmed this 
> issue still occurs.
> >
>
> Are you using it in master or slave mode?
>

For the i.MX28 EVK, the SGTL5000 is in slave mode.

-- 
Craig McQueen
