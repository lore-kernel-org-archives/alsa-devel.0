From: "Agarwal, Lomesh" <lomesh.agarwal@intel.com>
Subject: encoded media offload
Date: Fri, 24 Sep 2010 10:22:23 -0700
Message-ID: <FBD706E986F2704B946A44864E4E994E021760FB1F@orsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DBE02455A
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 19:22:27 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
I am working on board which has audio DSP. DSP can decode MP3 media. Current Linux shipped with the board sends only PCM thru ALSA stack. I wanted to see if I can offload MP3 playback. I heard that present ALSA doesn't support MP3. Wondering if somebody can enumerate the possible problems.

Thanks,
Lomesh
