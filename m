From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [Patch V5 01/12] MAINTAINERS: Add QCOM audio ASoC maintainer
Date: Wed, 11 Feb 2015 18:10:04 -0800
Message-ID: <1423707015-14527-2-git-send-email-kwestfie@codeaurora.org>
References: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423707015-14527-1-git-send-email-kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Add maintainers for the Qualcomm Technologies
sound drivers.

Signed-off-by: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d66a97dd3a12548e0f79c59154260724da11f282..9beda051e158156e2f7742485059ca299ed6a3d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5183,6 +5183,13 @@ F:	drivers/char/ipmi/
 F:	include/linux/ipmi*
 F:	include/uapi/linux/ipmi*
 
+QCOM AUDIO (ASoC) DRIVERS
+M:	Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
+M:	Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
+L:	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org (moderated for non-subscribers)
+S:	Supported
+F:	sound/soc/qcom/
+
 IPS SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid-ugMvIWC9OiRBDgjK7y7TUQ@public.gmane.org>
 L:	linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
