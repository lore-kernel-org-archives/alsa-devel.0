From: Paul Davis <pbd@op.net>
Subject: Re: Configuration Spaces
Date: Mon, 16 Sep 2002 14:33:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17r1Ja-0001U3-00@usw-sf-list1.sourceforge.net>
References: <20020916110722.A28835@atl.lmco.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 16 Sep 2002 11:07:22 EDT."
             <20020916110722.A28835@atl.lmco.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Chuck Winters <cwinters@atl.lmco.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>	1) Is the configuration space specific to each device, or each opened s
>tream?

each open stream. obviously, its related to the underlying physical
device, but you're semantically operation on one stream.

--p




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
