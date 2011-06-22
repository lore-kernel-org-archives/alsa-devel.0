From: Patrick Lai <plai@codeaurora.org>
Subject: Query about SNDRV_PCM_FORMAT_GSM
Date: Wed, 22 Jun 2011 00:39:27 -0700
Message-ID: <4E019C2F.1020007@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id BE0952453C
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 09:39:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, waiw@codeaurora.org, asishb@codeaurora.org, jaywang@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Hi,

I see SNDRV_PCM_FORMAT_GSM is defined in asound.h. However, I do not
find any reference to this macro except pcm_misc.c. I am curious how
bps info(i.e 4.75 kbit/s) is passed down to the ALSA driver. Any
pointers?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
