From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: 2.6.29 Vs 2.6.30
Date: Tue, 12 May 2009 16:32:01 +0530
Message-ID: <98769532B4BB14429434178695419EAE4D82A32C@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id DA4C8103838
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 13:02:32 +0200 (CEST)
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

I was developing a driver on 2.6.29 and it was playing using aplay properly but when I moved to 2.6.30, same code base is giving me underrun messages. 

What is the changes with respect to this in 2.6.30? Primarily, why do underrun messages come and how does driver need to handle it?

Any clue will be of great help.

Thanks,
Harsha
