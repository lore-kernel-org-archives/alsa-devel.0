From: "Li, Steve" <Steve.Li@imaginecommunications.com>
Subject: Re: ALSA license
Date: Thu, 31 Mar 2016 14:04:52 +0000
Message-ID: <3CD7D8096827214EA72BFDC6B95C7CC931B57833@VEREXCH02.harrisbroadcast.com>
References: <3CD7D8096827214EA72BFDC6B95C7CC931B5654F@VEREXCH02.harrisbroadcast.com>
 <56FC818C.8090601@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 967CD26665A
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 16:05:51 +0200 (CEST)
In-Reply-To: <56FC818C.8090601@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for your response. My goal is to implement audio playback in my application. The input is PCM audio buffers. I will also need to query the timing information so that I can synchronize the playback with video.

I am just starting to look at ALSA. I'd appreciate if you can point me to the software that I need. I am trying to check the license information before I start my development.
 
Thanks
Steve

-----Original Message-----
From: Takashi Sakamoto [mailto:o-takashi@sakamocchi.jp] 
Sent: March-30-16 9:47 PM
To: Li, Steve; alsa-devel@alsa-project.org
Subject: Re: ALSA license

Hi,

On Mar 30 2016 04:06, Li, Steve wrote:
> I am trying to use ALSA in a commercial application. I see that in the 
> introduction page, ALSA is licensed under GPL and LGPL. Can you tell 
> me which part of ALSA is licensed under LGPL? What is the best way to find out this information?

It's just reading license information included in each software packages (in most cases COPYRIGHT file). Under ALSA project, several softwares are developed. Which softwares do you plan to use?


Regards

Takashi Sakamoto

______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud service.
For more information please visit http://www.symanteccloud.com ______________________________________________________________________

______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud service.
For more information please visit http://www.symanteccloud.com
______________________________________________________________________
