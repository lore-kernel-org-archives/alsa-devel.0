From: Ross Vandegrift <ross@willow.seitz.com>
Subject: Re: Please add snd-ice1712 problem to "Known bugs" page
Date: Wed, 10 Sep 2003 17:41:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030910214122.GA7751@willow.seitz.com>
References: <200309101206.h8AC6xW9005709@oud> <7616-64105@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <7616-64105@sneakemail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sam <4l8uie002@sneakemail.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 10, 2003 at 01:17:33PM -0700, Sam wrote:
> Chances are M-Audio put some thought into the +4dBu,
> Consumer, and -10dbV presets.  Does anyone know how we could map these
> to the corresponding 7 bit values?  I could probably patch envy24control
> to add analog signal presets so we could have the best of both features.

That would ultimately be the best route - we'd keep maximum flexability,
but people would be able to quickly set to standard values as well.

I'd probably never use it, since I'm already much to used to having a
whole range of values to choose from...

-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.       It is a Canon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
