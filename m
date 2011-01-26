From: "Harrod, John" <john.harrod@philips.com>
Subject: Re: Triggering a DAPM widget event
Date: Wed, 26 Jan 2011 21:38:53 +0100
Message-ID: <39D4D143FC30524CAB784A72ADFECEEE34A0E8F455@NLCLUEXM02.connect1.local>
References: <39D4D143FC30524CAB784A72ADFECEEE34A0BC92CA@NLCLUEXM02.connect1.
	local><20110126165347.GB10759@sirena.org.uk><39D4D143FC30524CAB784A72ADFECEEE34A0E8F3DF@NLCLUEXM02.connect1.local>
	<20110126182754.GJ8501@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id CAB4A103A1B
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 21:39:37 +0100 (CET)
In-Reply-To: <20110126182754.GJ8501@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> What is your actual problem here?

I have a speaker widget (snd_soc_dapm_spk) whose event handler only receives a
SND_SOC_DAPM_PRE_PMD event when the pcm is closed.

The information contained in this message may be confidential and legally protected under applicable law. The message is intended solely for the addressee(s). If you are not the intended recipient, you are hereby notified that any use, forwarding, dissemination, or reproduction of this message is strictly prohibited and may be unlawful. If you are not the intended recipient, please contact the sender by return e-mail and destroy all copies of the original message.
