From: David Stuart <dave@sipquest.com>
Subject: Re: documentation - yeah right!
Date: 20 May 2003 18:11:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053468671.32362.21.camel@dave.sipquest.com>
References: <Pine.LNX.4.44.0305202327370.17272-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0305202327370.17272-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-05-20 at 16:52, Kai Vehmanen wrote:
> On Tue, 20 May 2003, Cliff Bradshaw wrote:
> 
> > doxygen is just an excuse to avoid writing documentation and should be
> > banned from all projects. If I want a list of all the damn globals I'll
> > look in the source code thankyou.
> 
> That's just not true at all. Existing ALSA API reference documentation
> (written using the Doxygen notation) provides far more info than just a
> list of globals. It's not perfect, but still, making false claims like
> that is not a very good way to start a discussion.

Agreed, but he's probably simply frustrated and prone to exaggeration..

Being a newbie myself, I agree that doxygen is certainly useful (since I
come from java where javadoc rules and is very similar), but I guess
what's missing is more of the high-level picture. Some discussions about
the main objects/concepts of the system, why they exist, what their
responsibilities are, how they interact, etc..

There is of course, some of this in the doxygen docs, but there could be
more.

These kinds of things really help ease the learning curve. Right now,
the only thing you can do in some cases is flip around and try to glean
the higher level purpose of a section from its methods.

-- 
David Stuart, SIPQuest
phone: 254-8886 x234 web: http://www.sipquest.com/



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
