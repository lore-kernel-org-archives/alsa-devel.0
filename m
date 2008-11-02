From: Alexander Werner <alexander.werner@lambda-audiosystems.de>
Subject: Intel G45 8-Channel LPCM over HDMI
Date: Sun, 2 Nov 2008 15:16:49 +0100
Message-ID: <8D978A35-5424-4BB5-980A-8F74EE529876@lambda-audiosystems.de>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from v471.vanager.de (v471.vanager.de [85.119.158.150])
	by alsa0.perex.cz (Postfix) with ESMTP id CFD0424131
	for <alsa-devel@alsa-project.org>; Sun,  2 Nov 2008 15:16:50 +0100 (CET)
Received: from [192.168.1.10] (pD95018EC.dip0.t-ipconnect.de [217.80.24.236])
	by v471.vanager.de (Postfix) with ESMTP id 08A9861A400E
	for <alsa-devel@alsa-project.org>; Sun,  2 Nov 2008 15:16:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm planning to build a linux-based, small sized PC for hearing aid  
acousticians.
It would be highly unfavorable, if the connection between Receiver and  
PC was
analog, because of the lower quality and the high number of cables.
I searched for a appropriate mainboard, and found the DG45FC, which  
fits my needs
perfectly, apart from the missing audio over HDMI support.
Is there any plan to support multichannel LPCM output over HDMI on the  
Intel G45
platform?
If not, is there anyone willing to implement HDMI support for the G45  
chipset if
I donate the needed hardware (permanently)?
But if there's no chance to implement it in the near future, has  
anyone experience
with an onboard chipset with multichannel LPCM over HDMI and ALSA  
support?

Thanks,

Alexander Werner
