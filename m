From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: bug tracking?
Date: Tue, 20 May 2003 12:34:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ECA12B5.3050903@superbug.demon.co.uk>
References: <s5h3cjgfuwn.wl@alsa2.suse.de>	<Pine.LNX.4.44.0305151112200.9877-100000@pnote.perex-int.cz>	<s5hznloeej6.wl@alsa2.suse.de>	<3EC3680A.60904@boosthardware.com> <s5hy918e5hq.wl@alsa2.suse.de> <3EC98C71.4090904@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-39.mail.demon.net (anchor-post-39.mail.demon.net [194.217.242.80])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA31634
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2003 13:44:34 +0200
In-Reply-To: <3EC98C71.4090904@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Takashi Iwai wrote:
> 
>>
>> i'm familiar with bugzilla (not as an adamin but as a user :) and am
>> satisfied almost with it.  it's enough powerful.
>> but bugzilla has many configurations and we'll need to find out the
>> fitting one for our purpose.
> 
> 
> I'm looking at it now. The first thing that jumps out at me is that all 
> users have to login to make a submission online.
> 
> IMO that will make it less likely for people to submit reports. However 
> the rest of the system is very slick so I'm not sure what direction to 
> take. There doesn't seem to be a way to turn of the login as it seems to 
> be crucial to making sure the system works.
> 
I would tend to disagree with you here. I think that it is vital that 
the person submitting the bug does log in, and has a verified email address.
My reason for this is in the answer to the following question from the 
developer: -
1) I think I have fixed the bug, can you please try this patch and tell 
me if it works.

Now, if the person who reported the bug just logged the bug report 
anonymously, the developer might never know if they have fixed the 
problem or not, so the developer is probably unlikely to try to fix it 
in the first place.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
