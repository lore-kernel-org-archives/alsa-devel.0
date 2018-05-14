From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH v3 6/6] MAINTAINERS: Add ALSA: xen-front: maintainer entry
Date: Mon, 14 May 2018 09:27:42 +0300
Message-ID: <20180514062742.25879-7-andr2000@gmail.com>
References: <20180514062742.25879-1-andr2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514062742.25879-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
Cc: andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Add myself as sound/xen maintainer.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92be777d060a..bd214e061359 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15494,6 +15494,13 @@ S:	Supported
 F:	arch/x86/xen/*swiotlb*
 F:	drivers/xen/*swiotlb*
 
+XEN SOUND FRONTEND DRIVER
+M:	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
+L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	sound/xen/*
+
 XFS FILESYSTEM
 M:	Darrick J. Wong <darrick.wong@oracle.com>
 M:	linux-xfs@vger.kernel.org
-- 
2.17.0
