From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: question on snd_jack_report
Date: Wed, 21 Oct 2009 18:22:47 +0530
Message-ID: <98769532B4BB14429434178695419EAE6A32FA1A@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E223724151
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Oct 2009 14:56:15 +0200 (CEST)
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
Cc: "Harsha, Priya" <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

When I call snd_jack_report with the status of the jack, from the user user space which parameter should I check in the sys/class/input/input2 to know if the jack is present or not?

Thanks,
Harsha.
